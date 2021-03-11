class Person < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers:[:facebook, :github, :google_oauth2]


  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |person|

      person.email = provider_data.info.email || "#{provider_data.info.nickname}@github.com"
      person.password = Devise.friendly_token[0, 20]
    end
  end
  mount_uploader :avatar, AvatarUploader
end
