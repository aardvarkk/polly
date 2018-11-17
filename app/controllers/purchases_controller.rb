class PurchasesController < ApplicationController
	def fiscal_years
		respond_to do |format|
		  format.json { render json: Purchase.pluck('DISTINCT fiscal_year').sort }
		end
	end

  def index
  	purchases = Purchase.all

  	if params[:amount_cents]
  		case params[:amount_cents].keys.first
  		when 'lt'
  			purchases = purchases.where("amount_cents < ?", params[:amount_cents]['lt'])
  		when 'le'
  			purchases = purchases.where("amount_cents <= ?", params[:amount_cents]['le'])
  		when 'gt'
  			purchases = purchases.where("amount_cents > ?", params[:amount_cents]['gt'])
  		when 'ge'
  			purchases = purchases.where("amount_cents >= ?", params[:amount_cents]['ge'])
  		when 'ne'
  			purchases = purchases.where("amount_cents != ?", params[:amount_cents]['ne'])
  		else
  			purchases = purchases.where(amount_cents: params[:amount_cents])
  		end
  	end

  	if params[:category_id]
  		purchases = purchases.joins({ code: :category }).where(codes: { category_id: params[:category_id].split(',') })
  	end

  	if params[:code_id]
  		purchases = purchases.where(code_id: params[:code_id].split(','))
  	end

  	if params[:contract_number]
  		purchases = purchases.where(contract_number: params[:contract_number].split(','))
  	end

  	if params[:contract_style_id]
  		purchases = purchases.where(contract_style_id: params[:contract_style_id].split(','))
  	end

  	if params[:department_id]
  		purchases = purchases.where(department_id: params[:department_id].split(','))
  	end

  	if params[:fiscal_year]
  		purchases = purchases.where(fiscal_year: params[:fiscal_year].split(','))
  	end

  	if params[:location_id]
  		purchases = purchases.where(location_id: params[:location_id].split(','))
  	end

  	if params[:order_number]
  		purchases = purchases.where(order_number: params[:order_number].split(','))
  	end

  	if params[:purchased_on]
  		purchases = purchases.where(purchased_on: params[:purchased_on].split(','))
  	end

  	if params[:source_id]
  		purchases = purchases.joins(:code).where(codes: { source_id: params[:source_id].split(',') })
  	end

  	if params[:vendor_id]
  		purchases = purchases.where(vendor_id: params[:vendor_id].split(','))
  	end

  	if params[:yukon]
  		purchases = purchases.where(yukon: params[:yukon].split(','))
  	end

  	if params[:agg]
  		if params[:group_by]
  			purchases = purchases.joins({ code: :category }).group(*params[:group_by].split(',').map(&:to_sym))
  		end

  		case params[:agg]
  		when "sum"
  			result = purchases.sum(:amount_cents)
  		when "avg"
  			result = purchases.average(:amount_cents)
  		when "min"
  			result = purchases.minimum(:amount_cents)
  		when "max"
  			result = purchases.maximum(:amount_cents)
  		when "count"
  			result = purchases.count(:amount_cents)
  		end

  		if result.is_a? Hash
  			result = result.map do |array_key, agg|
  				h = params[:group_by].split(',').zip([*array_key]).to_h
  				h[params[:agg].to_sym] = agg
  				h
  			end
  		else
  			result = [{ params[:agg].to_sym => result }]
  		end

  	else
  		result = purchases.order(:id)
  	end

		respond_to do |format|
		  format.json { render json: result }
		end
  end
end
