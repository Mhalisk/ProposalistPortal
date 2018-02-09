module JobsHelper
  def display_company_name(company_id)
    @company_name = String.new

    if company_id == 1
      @company_name = "Encor Solar"
    elsif company_id == 2
      @company_name = 'Powerhome Solar'
    else 
      @company_name = 'Unknown company, please contact the administrator'
    end
  end

  def display_locations(location_id)
    @location = String.new

    if location_id == 1
      @location = "Arizona"
    elsif location_id == 2
      @location = 'California (North)'
    elsif location_id == 3
      @location = 'California (South)'
    elsif location_id == 4
      @location = 'Connecticut'
    elsif location_id == 5
      @location = 'Florida'
    elsif location_id == 6
      @location = 'Massachusetts'
    elsif location_id == 7
      @location = 'Nevada'
    elsif location_id == 8 
      @location = 'New York (Long Island)'
    elsif location_id == 9
      @location  = 'New York (NYC | The Boroughs)'
    elsif location_id == 10
      @location = 'Rhode Island'
    elsif location_id == 11
      @location = 'Texas (Austin Energy | Oncor)'
    elsif location_id == 12
      @location = 'Texas (San Antonio | CPS)'
    elsif location_id == 13
      @location = 'Utah'
    else
      @location = 'Unknown Location, please contact the administrator'
    end
  end
end
