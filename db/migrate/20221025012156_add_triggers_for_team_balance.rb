class AddTriggersForTeamBalance < ActiveRecord::Migration[7.0]
  # Trigger when: assign Team to a Client,
  # add/remove Collaborator to Team,
  # change seniority of collaborator
  def up
    execute <<-SQL

      CREATE FUNCTION balance_for_team(team_id bigint) RETURNS double precision
        AS $$
        BEGIN
          return(
            with count_by_seniority as (
              select
              seniority, count(*) as counting from collaborators c
              INNER JOIN collaborators_teams ct ON c.id = ct.collaborator_id
              where ct.team_id = $1
              group by seniority
            ),
            count_senior as (
              select coalesce(sum(counting),0) as counting from count_by_seniority where lower(seniority) = 'senior'
            ),
            count_middle as (
              select coalesce(sum(counting),0) as counting from count_by_seniority where lower(seniority) = 'middle'
            ),
            count_junior as (
              select coalesce(sum(counting),0) as counting from count_by_seniority where lower(seniority) = 'junior'
            )
            select 100 - ABS(20 - sr.counting * 100/sum(cs.counting)) - ABS(30 - md.counting * 100/sum(cs.counting)) - ABS(50 - jr.counting * 100/sum(cs.counting))
            as return_value
            from count_by_seniority cs,
            count_senior sr,
            count_middle md,
            count_junior jr
            group by sr.counting, md.counting, jr.counting
            LIMIT 1
          );
        END;
        $$  LANGUAGE plpgsql;

      --- trigger functon/data change trigger
      CREATE FUNCTION update_balance_for_teams() RETURNS trigger
        AS $$
          BEGIN
            INSERT INTO team_balances (balance, balance_date, team_id, account_id, created_at, updated_at)
            SELECT balance_for_team(NEW.id), current_date, t.id, p.account_id, current_timestamp, current_timestamp
            FROM teams t INNER JOIN projects p on t.project_id=p.id AND t.id=NEW.id;
            return null;
          END;
        $$ LANGUAGE plpgsql;

      CREATE FUNCTION update_balance_for_collaborators_teams() RETURNS trigger
        AS $$
          BEGIN
            IF (TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
              INSERT INTO team_balances (balance, balance_date, team_id, account_id, created_at, updated_at)
              SELECT balance_for_team(NEW.team_id), current_date, t.id, p.account_id, current_timestamp, current_timestamp
              FROM teams t INNER JOIN projects p on t.project_id=p.id AND t.id=NEW.team_id;
            END IF;
            IF (TG_OP = 'UPDATE' OR TG_OP = 'DELETE') THEN
              INSERT INTO team_balances (balance, balance_date, team_id, account_id, created_at, updated_at)
              SELECT balance_for_team(OLD.team_id), current_date, t.id, p.account_id, current_timestamp, current_timestamp
              FROM teams t INNER JOIN projects p on t.project_id=p.id AND t.id=OLD.team_id;
            END IF;
            return null;
          END;
        $$ LANGUAGE plpgsql;

      CREATE FUNCTION update_balance_for_collaborators() RETURNS trigger
        AS $$
          BEGIN
            INSERT INTO team_balances (balance, balance_date, team_id, account_id, created_at, updated_at)
            SELECT balance_for_team(t.id), current_date, t.id, p.account_id, current_timestamp, current_timestamp
            FROM collaborators_team ct INNER JOIN teams t ON ct.team_id = t.id
            INNER JOIN projects p on t.project_id=p.id
            WHERE ct.collaborator_id = NEW.id;
            return null;
          END;
        $$ LANGUAGE plpgsql;

      CREATE TRIGGER update_balance_after_team_account
        AFTER INSERT OR UPDATE OF project_id
        ON teams
        FOR EACH ROW
        EXECUTE FUNCTION update_balance_for_teams();

      CREATE TRIGGER update_balance_after_collaborators_teams
        AFTER INSERT OR DELETE OR UPDATE
        ON collaborators_teams
        FOR EACH ROW
        EXECUTE FUNCTION update_balance_for_collaborators_teams();

      CREATE TRIGGER update_balance_after_collaborator_seniority
        AFTER UPDATE OF seniority
        ON collaborators
        FOR EACH ROW
        EXECUTE FUNCTION update_balance_for_collaborators();
    SQL
  end
  def down
    execute <<-SQL
      DROP TRIGGER update_balance_after_team_account on teams;
      DROP TRIGGER update_balance_after_collaborators_teams on collaborators_teams;
      DROP TRIGGER update_balance_after_collaborator_seniority on collaborators;
      DROP FUNCTION update_balance_for_collaborators;
      DROP FUNCTION update_balance_for_collaborators_teams;
      DROP FUNCTION update_balance_for_teams;
      DROP FUNCTION balance_for_team;
    SQL
  end
end
