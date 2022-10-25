# frozen_string_literal: true

module Api
  module  V1
    module Managers
      module Accounts
        class CollaboratorsController < ApiController
          def destroy
            begin
              CollaboratorRepository.delete_collaborator_from_account(collaborator_team_ids, params[:collaborator_id])
            rescue ActiveRecord::RecordNotFound => invalid
              return render json: { message: invalid }, status: :bad_request
            end
            render json: { message: "user deleted" }, status: :ok
          end

          private
            def collaborator_team_ids
              account = AccountRepository.find(params[:account_id])
              CollaboratorToAccountService.new(
                account:, collaborator_id: params[:collaborator_id]
              ).retrive_collaborator_team_ids
            end
        end
      end
    end
  end
end
