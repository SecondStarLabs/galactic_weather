class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  before_validation :set_user_id, if: :email?
  attribute :email, :string

  def set_user_id
    # somewhat magical, but tested, see devise_invitable code or 
    # gorails.com episode around 22:00
    self.user = User.invite!(email: email)
  end
end
