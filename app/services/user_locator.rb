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
    # @locations = Location.near(@location, @radius)
    @users_in_location = Location.near(@location, @radius).collect(&:user)
    # @locations.each do |l|
    #       if @user_matching.to_a.include?(l.user)
    #         users << l.user
    #       end
    #     end

    # @instruments.each do |i|
    #   @generes.each do |g|
    #     @user_matching = User.search_by_genere(g.id).search_by_instrument(i.id)
        
    #   end
    # end
    users = User.search_by_genere(@generes).search_by_instrument(@instruments).distinct & @users_in_location
    # users.compact!
    # users = users.uniq

# improved version all in one with steven
        # users = User.search_by_genere(@generes).
        #           search_by_instrument(@instruments).
        #           distinct.
        #           where.not(id: @users_in_location)
    users.delete(@user)
    users
  end

  def self.call(options={})
    new(options).call
  end
end