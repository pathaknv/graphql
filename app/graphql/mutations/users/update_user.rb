# frozen_string_literal: true

module Mutations
  module Users
    # Update User Mutation
    class UpdateUser < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(params)
        user = User.find_by(id: params[:id])
        return { user: nil, errors: ["Can't find user"] } if user.nil?

        if user.update(params)
          { user: user, errors: [] }
        else
          { user: user, errors: user.errors.full_messages }
        end
      end
    end
  end
end
