class AddColumnToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :soundcloud_id, :string
    add_column :tracks, :soundcloud_created_at, :datetime
    add_column :tracks, :soundcloud_user_id, :integer
    add_column :tracks, :soundcloud_duration, :integer
    add_column :tracks, :soundcloud_tag_list, :string
    add_column :tracks, :soundcloud_genre, :string
    add_column :tracks, :soundcloud_description, :string
    add_column :tracks, :soundcloud_title, :string
    add_column :tracks, :soundcloud_track_type, :string
    add_column :tracks, :soundcloud_license, :string
    add_column :tracks, :soundcloud_user_playback_count, :integer
    add_column :tracks, :soundcloud_permalink_url, :string
    add_column :tracks, :soundcloud_stream_url, :string
    add_column :tracks, :soundcloud_download_url, :string
    add_column :tracks, :soundcloud_waveform_url, :string
    add_column :tracks, :soundcloud_playback_count, :integer
    add_column :tracks, :soundcloud_download_count, :integer
    add_column :tracks, :soundcloud_favoritings_count, :integer
    add_column :tracks, :soundcloud_comment_count, :integer
    add_column :tracks, :soundcloud_uri, :string
    add_column :tracks, :soundcloud_artwork_url, :string
    add_column :tracks, :soundcloud_downloadable, :boolean
    add_column :tracks, :soundcloud_user_favorite, :boolean
  end
end
