module Photish
  module Gallery
    module Traits
      module Albumable
        def albums
          @albums ||= Dir.entries(path)
                         .reject { |file| ['.', '..'].include?(file)  }
                         .map    { |file| File.join(path, file)       }
                         .reject { |file| !Dir.exist?(file)           }
                         .map    { |file| album_class.new(self, file) }
        end

        def all_entities
          all_albums +
            all_photos +
            all_pages +
            all_images
        end

        def all_albums
          @all_albums ||= albums.map { |album| [album] + album.all_albums }
                                .flatten
        end

        def all_photos
          @all_photos ||= all_albums.map(&:photos)
                                    .concat(self.try(:photos) || [])
                                    .flatten
        end

        def all_pages
          @all_pages ||= all_albums.map(&:pages)
                                    .concat(self.try(:pages) || [])
                                    .flatten
        end

        def all_images
          @all_images ||= all_photos.map(&:images)
                                    .flatten
        end
      end
    end
  end
end
