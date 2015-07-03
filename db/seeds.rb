# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! :first_name            => 'Jacek',
             :last_name             => 'Piotrowski',
             :nickname              => 'jpiotro3',
             :email                 => 'jpiotro3@gmail.com',
             :role                  => 'admin',
             :password              => 'admin',
             :password_confirmation => 'admin',
             :use_full_name         => true,
             :incl_in_thesis        => true,
             :incl_in_rankings      => true

User.create! :first_name            => 'Test',
             :last_name             => 'Tester',
             :nickname              => 'test1',
             :email                 => 'jpiotro3@gmail.com',
             :role                  => 'user',
             :password              => 'test',
             :password_confirmation => 'test',
             :use_full_name         => true,
             :incl_in_thesis        => true,
             :incl_in_rankings      => true
