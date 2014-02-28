require_relative './elevator.rb'

describe Elevator do
  before(:each) do
    @e = Elevator.new(13)
  end

  it "should have a number of floors" do
    @e.number_of_floors.should == 13
  end

  it "should accept new requests" do
    @e.request(1,2)
    @e.queue.should == [[1,2]]
  end

  it "should put requests for the current direction starting on floors
    that have already been passed after requests for the opposite direction" do
    @e.current_floor = 3
    @e.current_direction = 'up'
    @e.request(1,5)
    @e.request(4,2)
    @e.queue.should == [[4,2],[1,5]]
  end

  it "should put requests for the opposite direction after requests for the
    current direction on floors that have not been passed yet" do
    @e.current_floor = 3
    @e.current_direction = 'up'
    @e.request(4,5)
    @e.request(4,2)
    @e.queue.should == [[4,5],[4,2]]
  end
  
  it "should put requests for the opposite direction in proper order" do
    @e.current_floor = 3
    @e.current_direction = 'up'
    @e.request(5,4)
    @e.request(6,'down')
    @e.queue.should == [[6,'down'],[5,4]]
  end
  
  it "should put requests for the current direction for floors that
    haven't been reached yet in the proper order" do
    @e.current_floor = 7
    @e.current_direction = 'down'
    @e.request(5,4)
    @e.request(6,'down')
    @e.queue.should == [[6,'down'],[5,4]]
  end
  
  it "should put requests for the current direction for floors that
    have already been passed in the proper order" do
    @e.current_floor = 3
    @e.current_direction = 'down'
    @e.request(5,4)
    @e.request(6,'down')
    @e.queue.should == [[6,'down'],[5,4]]
  end
end