admin_user = User.new(name: 'DOE', firstname: 'John', login: 'test@test.com', password: 'azerty', password_confirmation: 'azerty', is_active: 1, is_admin: 1)
admin_user.save
