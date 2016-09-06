class Song < ActiveRecord::Base
  validates :title, presence: true
  validate :no_repeat_songs
  validates :released, inclusion: {in: [true, false]}
  validates :release_year, presence: true, if: "self.released"
  validates :release_year, numericality: {less_than_or_equal_to: Time.now.year}, if: "self.released"

  def no_repeat_songs
    song = Song.find_by(title: self.title)
    if song && self.id != song.id
      if song.released && self.released && song.release_year == self.release_year
        errors.add(:release_year, "song must be unique")
      end
    end
  end
end