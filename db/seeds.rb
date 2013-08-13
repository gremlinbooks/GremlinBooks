# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#AOII
Tenant.create(sub_domain: 'aoii',
              logo: 'aoii_logo.jpeg',
              color: 'Red',
              title: 'AOII.grmbkstr',
              amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
              amazon_secret_key: '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',
              amazon_associate_tag: 'aoii-grmbkstr-20',
              bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
              bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
              bookbyte_publisher_id: 'K620292',
              cj_website_id: '7208985',
              cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
              cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
              bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
              bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
              chegg_base_url: 'http://api.chegg.com/rent.svc',
              chegg_password: '4190344',
              chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
              chegg_aid: '10692263',
              chegg_pid: '7208985',
              chegg_sid: ""
)



