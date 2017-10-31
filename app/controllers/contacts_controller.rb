class ContactsController < ApplicationController
 def index
   @places = ([
     { name: '東京駅', description: '東京駅東京駅東京駅', latitude: '35.681298', longitude: '139.7640529' },
     { name: 'スカイツリー', description: '634m', latitude: '35.7100627', longitude: '139.8085117' },
   ])

   @hash = Gmaps4rails.build_markers(@places) do |place, marker|
     marker.lat place[:latitude]
     marker.lng place[:longitude]
     marker.infowindow place[:name]
   end
 end
end
