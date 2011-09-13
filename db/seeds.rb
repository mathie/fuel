unless User.exists?(email: 'mathie@woss.name')
  user = User.new email: 'mathie@woss.name',
    password:              'password',
    password_confirmation: 'password',
    name:                  'Graeme Mathieson'
  user.confirmed_at = Time.now
  user.save!
end

FuelPrice.import
