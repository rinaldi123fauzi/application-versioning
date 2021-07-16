class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :role_assignments, dependent: :destroy
  has_many :roles, through: :role_assignments
  devise :database_authenticatable, :recoverable, :validatable, :trackable

  has_one_attached :photo


  def can?(&block)
    roles.map(&:permissions).any?(&block)
  end
  
  def computed_permissions
    roles.map(&:computed_permissions).reduce(RoleCore::ComputedPermissions.new, &:concat)
  end
end
