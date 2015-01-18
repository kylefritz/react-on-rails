class PhotosController < ApplicationController
  def index
    @images = [
      {
        imageUrl: 'http://tinyurl.com/lkevsb9',
        caption: 'New York!'
      },
      {
        imageUrl: 'http://tinyurl.com/mxkwh56',
        caption: 'Cows'
      },
      {
        imageUrl: 'http://tinyurl.com/nc7jv28',
        caption: 'Scooters'
      }
    ]
  end
end
