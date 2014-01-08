class UserLocator
  attr_reader :location, :radius, :user, :instruments, :generes
  def initialize(options={})
    @location = options[:location]
    @user = options[:user]
    @instruments = options[:instruments]
    @generes = options[:generes]
    @radius = options[:radius]
  end

  def call
    users = []
    @locations = Location.near(@location, @radius)
    @instruments.each do |i|
      @generes.each do |g|
        @user_matching = User.search_by_genere(g.id).search_by_instrument(i.id)
        @locations.each do |l|
          if @user_matching.to_a.include?(l.user)
            users << l.user
          end
        end
      end
    end
    users.compact!
    users = @users.uniq
    users.delete(@user)
    users
  end

  def self.call(locations, user, instruments, generes)
    new(locations, user, instruments, generes).call
  end
end