class Api::V1::GreetingsController < ApplicationController
  before_action :set_message, only: %i[show update destroy]

  # GET /messages
  def index
    @messages = Message.all

    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  def random
    @message = Message.order('RANDOM()').first
    render json: @message

    # random_greeting = Message.order('RANDOM()').first
    # render json: { greeting: random_greeting.content }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content)
  end
end

# To create a new version of the api, using this below
# class Api::V2::GreetingsController < ApplicationController; end
# with a new file call v2 under api directory - make sure to add everything from v1
# with the new update for v2 and also create a route, like this for v1 and v2

# # Version 1 routes
# namespace :api do
#   namespace :v1 do
#     get 'random_greeting', to: 'greetings#random_greeting'
#   end
# end

# # Version 2 routes
# namespace :api do
#   namespace :v2 do
#     get 'random_greeting', to: 'greetings#random_greeting'
#   end
# end
