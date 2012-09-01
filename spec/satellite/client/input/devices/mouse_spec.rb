require 'spec_helper'
require 'satellite/client/input/devices/mouse'

describe Satellite::Client::Input::Devices::Mouse do

  describe 'clicked?' do
    it 'understands that the mouse button is held down' do
      mouse = Satellite::Client::Input::Devices::Mouse.new
      mouse.clicked?.should be_false
      mouse.button_down(65536)
      mouse.clicked?.should be_true
      mouse.button_up(65536)
      mouse.clicked?.should be_false
    end
  end

end