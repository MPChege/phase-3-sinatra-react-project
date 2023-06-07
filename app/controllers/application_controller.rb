class ApplicationController < Sinatra::Base
 set :default_content_type, 'application/json'
  # To enable cross origin requests for all routes:
  set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] = '*'
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS, PUT, DELETE"
  end
  
  # routes...
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  # GET -----------------------------------------------------------------------
    get '/sellers' do 
    Seller.all.to_json(include: {
      houses: {
        only: [:id, :price, :description, :size_in_sqft, :image],
        include: {
          location: {
            only: [:location]
          },
          category: {
            only: [:category]
          }
        }
      }
    })
  end

  get '/sellers/:id' do
    requested_category = Seller.where(:id => params[:id])

    if requested_category == []
      return {}.to_json
    else
      return Seller.find(params[:id]).to_json(include: {
        houses: {
            only: [:id, :price, :description, :size_in_sqft, :image],
            include: {
              location: {
                only: [:location],
              },
              category: {
                only: [:category]
              }
          }
        }
      })
    end
  end

  get '/categories' do 
    Category.all.to_json(include: {
      houses: {
        only: [:id, :price, :description, :size_in_sqft, :image],
        include: {
          location: {
            only: [:location]
          },
          seller: {
            only: [:name]
          }
        }
      }
    })
  end

  get '/categories/:id' do
    requested_category = Category.where(:id => params[:id])

    if requested_category == []
      return {}.to_json
    else
      return Category.find(params[:id]).to_json(include: {
        houses: {
            only: [:id, :price, :description, :size_in_sqft, :image],
            include: {
              location: {
                only: [:location],
              },
              seller: {
                only: [:name]
              }
          }
        }
      })
    end
  end

  get '/locations' do 
    Location.all.to_json(include: {
      houses: {
        only: [:id, :price, :description, :size_in_sqft, :image],
        include: {
          category: {
            only: [:category]
          },
          seller: {
            only: [:name]
          }
        }
      }
    })
  end

  get '/locations/:id' do
    requested_location = Location.where(:id => params[:id])

    if requested_location == []
      return {}.to_json
    else
      return Location.find(params[:id]).to_json(include: {
        houses: {
          only: [:id, :price, :description, :size_in_sqft, :image],
          include: {
            category: {
              only: [:category]
            },
            seller: {
              only: [:name]
            }
          }
        }
      })
    end
  end

  get '/houses' do
    requested_houses = House.all.map do |house|
      house_details(house)
    end

    requested_houses.to_json
  end

  get '/houses/:id' do
    requested_house = House.where(:id => params[:id])

    if requested_house == []
      return {}.to_json
    else
      house_details(House.find(params[:id])).to_json
    end
  end

  # PUT ----------------------------------------------------------------------------
  put '/houses' do
    requested_house = get_house(get_house_details(params))

    if requested_house == [] && no_nil_entry(params)
      new_house = House.create(
        location_id: get_location(location_name: params[:location]).id,
        category_id: get_category(category_name: params[:category]).id,
        seller_id: get_seller(seller_name: params[:seller]).id,
        price: params[:price],
        description: params[:description],
        size_in_sqft: params[:size_in_sqft],
        image: params[:image]        
      )
      return house_details(new_house).to_json
    else
      return requested_house.to_json
    end
  end

  # POST ---------------------------------------------------------------------------
  post '/houses' do
    requested_house = get_house(get_house_details(params))

    if no_nil_entry(params)
      new_house = House.create(
        location_id: get_location(location_name: params[:location]).id,
        category_id: get_category(category_name: params[:category]).id,
        seller_id: get_seller(seller_name: params[:seller]).id,
        price: params[:price],
        description: params[:description],
        size_in_sqft: params[:size_in_sqft],
        image: params[:image]        
      )
      return new_house.to_json      
    end
  end

  # DELETE -------------------------------------------------------------------------
  delete '/houses/:id' do
    requested_house = House.find_by(id: params[:id])
    if requested_house.nil?
      return {}.to_json
    else
      requested_house.destroy
      return {}.to_json
    end
  end

  # PATCH --------------------------------------------------------------------------
  patch '/houses/:id' do
    requested_house = House.find_by(id: params[:id])

    if !requested_house.nil?
      requested_house.update(
        location_id: get_id(get_location(location_name: params[:location]))  || requested_house.location_id,
        category_id: get_id(get_category(category_name: params[:category])) || requested_house.category_id,
        seller_id: get_id(get_seller(seller_name: params[:seller])) || requested_house.seller_id,
        price: params[:price] || requested_house.price,
        description: params[:description] || requested_house.description,
        size_in_sqft: params[:size_in_sqft] || requested_house.size_in_sqft,
        image: params[:image] || requested_house.image
      )
    end

    house_details(requested_house).to_json
  end


  # ALL OTHER ROUTES ---------------------------------------------------------------
  get '/*' do
    get_endpoint_error_message(request_name: "get").to_json
  end

  patch '/*' do
    get_endpoint_error_message(request_name: "patch").to_json
  end

  post '/*' do
    get_endpoint_error_message(request_name: "post").to_json
  end

  put '/*' do
    get_endpoint_error_message(request_name: "put").to_json
  end

  delete '/*' do
    get_endpoint_error_message(request_name: "delete").to_json
  end


  # ================================================================================
  private
  def house_details(house, remove: [])
    if(house.nil?)
      {}.to_json
    else
      result = {
        id: house.id,
        location_id: house.location_id,
        category_id: house.category_id,
        seller_id: house.seller_id,
        location: Location.find_by(id: house.location_id).location,
        category: Category.find_by(id: house.category_id).category,
        seller: Seller.find_by(id: house.seller_id).name,
        price: house.price,
        description: house.description,
        size_in_sqft: house.size_in_sqft,
        image: house.image
      }

      remove.each do |key|
        result.delete(key)
      end

      result
    end
  end

    def get_seller(seller_name:)
    if seller_name.is_a?(String)
      seller = Seller.find_by(name: seller_name)
      seller_exists = !seller.nil?
      if seller_exists
        return seller
      else
        return Seller.create(name: seller_name)
      end
    else
      nil
    end
  end

  def get_location(location_name:)
    if location_name.is_a?(String)
      location = Location.find_by(location: location_name)
      location_exists = !location.nil?
      if location_exists
        return location
      else
        return Location.create(location: location_name)
      end
    else
      nil
    end
  end

  def get_category(category_name:)
    if category_name.is_a?(String)
      category = Category.find_by(category: category_name)
      category_exists = !category.nil?
      if category_exists
        return category
      else
        return Category.create(category: category_name)
      end     
    else
      nil
    end
  end

  def get_house(house_details)
    base_sql_query = get_base_query(house_details)
    full_query = get_full_query(base_query:base_sql_query, house_details: house_details)

    House.find_by_sql full_query
  end

  def get_base_query(house_details)
    base_sql = "SELECT * FROM houses WHERE "
    house_details.each do |key, val|
      if !val.nil?
        base_sql = base_sql + key.to_s + "= ? AND "
      end
    end
    
      #remove the last AND
      base_sql[0..-5]
  end

  def get_full_query(base_query:, house_details:)
    full_sql_query = [base_query]
    house_details.each do |key, val|
      if !val.nil?
        full_sql_query << val
      end
    end

    full_sql_query
  end

  def get_house_details(params)
    location = get_location(location_name: params[:location])
    category = get_category(category_name: params[:category])
    seller = get_seller(seller_name: params[:seller])
    
    house_details = {
        location_id: location.id,
        category_id: category.id,
        seller_id: seller.id,
        price: params[:price],
        description: params[:description],
        size_in_sqft: params[:size_in_sqft],
        image: params[:image]
      }
  end

  def get_expected_entries
    [
      "location",
      "category",
      "seller",
      "price",
      "description",
      "size_in_sqft",
      "image"
    ]
  end

  def no_nil_entry(params)
    expected_entries = get_expected_entries

    expected_entries.each do |param_key|
      if params[param_key.to_sym].nil?
        return false
      end
    end

    return true
  end

  def get_id(attr)
    if attr
      attr.id
    else
      nil
    end
  end

  def get_endpoint_error_message(request_name:)
    {EndpointError: "The endpoint you are using can't be accessed with a #{request_name} request"}
  end
end
