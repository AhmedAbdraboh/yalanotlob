json.extract! ordermember, :id, :user_id, :order_id, :status, :created_at, :updated_at
json.url ordermember_url(ordermember, format: :json)
