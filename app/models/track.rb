class Track < ActiveRecord::Base
  extend Enumerize

  enumerize :version, in: [:Sketch, :Rough, :Final]
  enumerize :genre, in: [:Ambient, :Classical, :Dancehall, :DeepHouse, :Disco, :DrumnBass, :Electronic, :HipHop, :House, :Jazz, :Metal, :Pop, :Rap, :RnB, :Rock, :Soul, :Techno, :Trance, :TripHop]

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :name, :genre, :version, :user_id, presence: :true

  scope :fresh, -> do
    where.not(soundcloud_permalink_url: nil).
      # they're sorted by created_at
      order("created_at DESC")
  end

  scope :hot, -> do
    select("tracks.*, count(votes.id) as votes_count").
      # joins the amount of votes to each track (take in account when the track as 0 votes)
      joins("LEFT OUTER JOIN votes ON votes.track_id = tracks.id").
      # tracks need to have a permalink
      where.not(soundcloud_permalink_url: nil).
      group("tracks.id").
      # the tracks are order by votes, if same amount of votes, by date of creation
      order("votes_count DESC, tracks.created_at DESC")
  end

  scope :trending, -> do
    select("tracks.*, count(votes.id) as votes_count, (count(votes.id) - ((EXTRACT(hour FROM (NOW() - tracks.created_at))) / 12)) as points").
      # joins the amount of votes to each track (take in account when the track as 0 votes)
      joins("LEFT OUTER JOIN votes ON votes.track_id = tracks.id").
      # tracks need to have a permalink
      where.not(soundcloud_permalink_url: nil).
      group("tracks.id").
      # the tracks are order by votes, if same amount of votes, by date of creation
      order("points DESC, tracks.created_at DESC")
  end
end
