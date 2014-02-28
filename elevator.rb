class Elevator
  attr_accessor :number_of_floors, :current_floor, :current_direction

  def initialize( num )
    @number_of_floors = num

    # elevators start at floor 0, going up
    @current_floor = 0
    @current_direction = 'up'

    # three queues
    @current_dir = []
    @opposite_dir = []
    @passed = []
  end

  def queue
    # the main queue is ordered in this way to model the SCAN algorithm
    @current_dir.concat( @opposite_dir ).concat( @passed )
  end

  def request( from, to )
    dir = req_dir(from, to)
    
    # decide which queue the incoming request belongs to
    # TODO refactor: combine up/down
    if @current_direction == 'up'
      if dir == 'up'
        if from < @current_floor
          add_to_queue( @passed, from, to, @current_direction )
        else
          add_to_queue( @current_dir, from, to, @current_direction )
        end
      else
        add_to_queue( @opposite_dir, from, to, opposite_direction)
      end
    else
      if dir == 'down'
        if from > @current_floor
          add_to_queue( @passed, from, to, @current_direction )
        else
          add_to_queue( @current_dir, from, to, @current_direction )
        end
      else
        add_to_queue( @opposite_dir, from, to, opposite_direction)
      end
    end
  end

  private

  def add_to_queue( queue, from, to, order )
    # if there's nothing in the queue, then just add the current request
    if queue.empty?
      queue << [from, to] and return
    end

    new_dest = dest(from, to)
    # find the right place to insert the new request
    queue.each_with_index do |r,i|
      existing_dest = dest(r[0], r[1])
      if order == 'up'
        if new_dest < existing_dest
          queue.insert(i, [from, to]) and return
        end
      else
        if new_dest > existing_dest
          queue.insert(i, [from, to]) and return
        end
      end
    end
  end

  # helper methods

  def is_dir?( to )
    to == 'up' || to == 'down'
  end

  def dest( from, to )
    if is_dir? to
      from
    else
      to
    end
  end
  
  def req_dir( from, to )
    if to == 'up'
      dir = 'up'
    elsif to == 'down'
      dir = 'down'
    else
      dir = from > to ? 'down' : 'up'
    end
  end
  
  def opposite_direction
    @current_direction == 'up' ? 'down' : 'up'
  end
end