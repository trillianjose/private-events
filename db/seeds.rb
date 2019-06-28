# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Homero Simpson', email: 'homero@simpson.com')
User.create(name: 'Geralt de Rivia', email: 'geralt@rivia.com')
User.create(name: 'Keanu Reeves', email: 'keanu@reeves.com')

Event.create(title: 'Beach Party', schedule: Date.today, description: 'Bring your bikini')
Event.create(title: 'Bachelorete Party', schedule: Date.yesterday, description: 'Bye Keanu!')

Attendance.create(user_id: User.first.id, event_id: Event.first.id, role: 'owner')
Attendance.create(user_id: User.first.id, event_id: Event.second.id, role: 'assistent')
Attendance.create(user_id: User.second.id, event_id: Event.second.id, role: 'assistent')
Attendance.create(user_id: User.third.id, event_id: Event.second.id, role: 'owner')
Attendance.create(user_id: User.third.id, event_id: Event.first.id, role: 'assistent')
