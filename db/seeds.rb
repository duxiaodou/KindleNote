# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# permissions seed
permissions = [
  {'user-show'          =>    '用户-查看'},
  {'user-update'        =>    '用户-编辑'},
  {'user-destroy'       =>    '用户-删除'},
  {'book-create'        =>    '书籍-添加'},
  {'book-show'          =>    '书籍-查看'},
  {'book-update'        =>    '书籍-编辑'},
  {'book-destroy'       =>    '书籍-删除'},
  {'note-create'        =>    '笔记-添加'},
  {'note-show'          =>    '笔记-查看'},
  {'note-update'        =>    '笔记-编辑'},
  {'note-destroy'       =>    '笔记-删除'},
  {'fragment-create'    =>    '片段-添加'},
  {'fragment-show'      =>    '片段-查看'},
  {'fragment-update'    =>    '片段-编辑'},
  {'fragment-destroy'   =>    '片段-删除'},
]

permissions.each do |permission|
  Permission.create!(name: permission.keys.first, title: permission.values.first)
end

role_user = Role.create!(name: 'user')
role_admin = Role.create!(name: 'admin')


user_admin = User.create!(name: 'admin', email: 'admin@kindlenote.org',password: 'admin@kindlenote.org')
user_admin.add_role :admin
