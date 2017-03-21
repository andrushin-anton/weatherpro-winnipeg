# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Status.create! name: "Lead", color: "583030", description: "unassigned", status: "ACTIVE"
Status.create! name: "Assigned(Customer)", color: "FF902F", description: "NEW customer", status: "ACTIVE"
Status.create! name: "Reschedule", color: "3A29D2", description: "time and/or date changes for the appointment", status: "ACTIVE"
Status.create! name: "Up-sell", color: "F5E836", description: "Returning customer for new appointment", status: "ACTIVE"
Status.create! name: "Referral", color: "F5E836", description: "New customer coming from existing customer for new appointment", status: "ACTIVE"
Status.create! name: "Cancelled", color: "EC2D26", description: "by seller", status: "ACTIVE"
Status.create! name: "Sold", color: "4DB02F", description: "by seller", status: "ACTIVE"
Status.create! name: "Follow up", color: "B326C9", description: "by seller", status: "ACTIVE"