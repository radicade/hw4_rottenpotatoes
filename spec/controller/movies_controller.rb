require 'spec_helper'

describe MoviesController do
  describe 'searching TMDb' do
    it 'should call the model method that performs TMDb saerch' do
      Movie.should_receive(:find_in_tmdb).with('hardware')
      post :search_tmdb, {:search_Terms => 'hardware'}
    end
  end
end

