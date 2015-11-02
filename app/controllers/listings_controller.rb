require 'net/https'
require 'json'

class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all.sort_by { |listing| listing.value_score }
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @listing }
      else
        format.html { render action: 'new' }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end

  def pull
    # ripped from http://mislav.net/2011/07/faraday-advanced-http/
    url = URI.parse('http://rentnema.com/soap-api-4.php?type=0')

    response = Net::HTTP.start(url.host, use_ssl: false) do |http|
      http.get url.request_uri, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A'
    end

    case response
    when Net::HTTPRedirection
      # repeat the request using response['Location']
    when Net::HTTPSuccess
      listings_json = JSON.parse response.body
      fetch_date = Time.current
      Listing.all.each do |listing|
        listing.is_active = false
        listing.save
      end
      @units = listings_json['units']
      @units.each do |unit|
        listing = Listing.where(floor: unit['uf'], unit: unit['un'])
        unless listing.count > 0
          listing = Listing.new(floor: unit['uf'], unit: unit['un'], sqft: unit['sq'], bath: unit['bathType'], bed: 0, is_active: true) # TODO: 0 for now, use real number
          listing.save
        else
          listing = listing.first
          listing.is_active = true
          listing.save
        end
        current_price = unit['rent'].delete(',').to_i
        history = listing.rents
        last_rent = history.last
        unless history.count > 0 && last_rent[:price] == current_price
          rent = Rent.new(listing_id: listing.id, fetch_date: fetch_date, price: current_price)
          rent.save
        end
      end
      respond_to do |format|
        format.html { redirect_to listings_url, notice: 'Listings pulled successfully.' }
        format.json { listings_json }
      end
    else
      # response code isn't a 200; raise an exception
      response.error!
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:floor, :unit, :sqft, :bath, :bed)
    end
end
