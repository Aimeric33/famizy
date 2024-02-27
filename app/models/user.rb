class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :family_members, dependent: :destroy
  has_many :families, through: :family_members

  has_one_attached :avatar, dependent: :purge

  validates :name, presence: true, length: { minimum: 5 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :birth_date, presence: true

  after_create :generate_color

  def generate_color
    colors = %w[red orange yellow green teal blue indigo purple pink]
    self.update(color: colors.sample)
  end
end
