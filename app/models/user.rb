class User < ActiveRecord::Base
	has_many :tweets, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_user, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
	
	accepts_nested_attributes_for :tweets#, reject_if: proc { |attributes| attributes['content'].blank? }
	has_secure_password
	
	validates :username,:first_name, :age, :city , presence: true
	validates :email, uniqueness: true, presence: true
	validates :password, confirmation: true, length: { in: 6..20 }
	validates :username, uniqueness: true, format: { with: /\A[a-zA-Z]+\z/, message: "Username already exists" }
	validates :age, numericality: true
	
	before_save { self.email = email.downcase }
	
	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end
	
	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy!
	end
	
	def authenticate_user logged_password
		self.try(:authenticate, logged_password)
	end
end
