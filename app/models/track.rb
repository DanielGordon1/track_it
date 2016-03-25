class Track < ActiveRecord::Base
  extend Enumerize

  enumerize :version, in: [:Sketch, :Rough, :Final]
  enumerize :genre, in: [:Ambient, :Classical, :Dancehall, :DeepHouse, :Disco, :DrumnBass, :Electronic, :HipHop, :House, :Jazz, :Metal, :Pop, :Rap, :RnB, :Rock, :Soul, :Techno, :Trance, :TripHop]

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :name, :genre, :version, :user_id, presence: :true
end
