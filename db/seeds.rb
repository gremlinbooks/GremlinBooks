# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tenant.delete_all

#AOII
Tenant.create(sub_domain: 'aoii',
              logo: 'gremlin_small.png',
              color: 'Red',
              title: 'AOII Bookstore',
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
              chegg_sid: '',
              url: 'http://aoii.grmbkstr.com'
)

#Gremlin
Tenant.create(sub_domain: 'www',
              logo: 'gremlin_small.png',
              color: 'Default',
              title: 'Gremlin Books',
              amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
              amazon_secret_key: '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',
              amazon_associate_tag: 'wwwgremlinboo-20',
              bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
              bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
              bookbyte_publisher_id: 'K620292',
              cj_website_id: '7045869',
              cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
              cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
              bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
              bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
              chegg_base_url: 'http://api.chegg.com/rent.svc',
              chegg_password: '4190344',
              chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
              chegg_aid: '10692263',
              chegg_pid: '7045869',
              chegg_sid: '',
              url: 'http://www.gremlinbooks.com'
)

#Chi Psi
Tenant.create(sub_domain: 'chipsi',
              logo: 'chiPsi_small.png',
              color: 'Default',
              title: 'Chi Psi Bookstore',
              amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
              amazon_secret_key: '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',
              amazon_associate_tag: 'chipsi-grmbkstr-20',
              bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
              bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
              bookbyte_publisher_id: 'K620292',
              cj_website_id: '7225055',
              cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
              cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
              bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
              bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
              chegg_base_url: 'http://api.chegg.com/rent.svc',
              chegg_password: '4190344',
              chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
              chegg_aid: '10692263',
              chegg_pid: '7225055',
              chegg_sid: '',
              url: 'http://chipsi.grmbkstr.com'
)

#Alpha Sig
Tenant.create(sub_domain: 'alphasig',
              logo: 'AlphaSig.jpg',
              color: 'Default',
              title: 'Alpha Sig Bookstore',
              amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
              amazon_secret_key: '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',
              amazon_associate_tag: 'alphasig-grmbkstr-20',
              bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
              bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
              bookbyte_publisher_id: 'K620292',
              cj_website_id: '7208989',
              cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
              cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
              bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
              bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
              chegg_base_url: 'http://api.chegg.com/rent.svc',
              chegg_password: '4190344',
              chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
              chegg_aid: '10692263',
              chegg_pid: '7208989',
              chegg_sid: '',
              url: 'http://alphasig.grmbkstr.com'
)

#Sig Ep
Tenant.create(sub_domain: 'sigep',
              logo: 'SigEpLogo_small.png',
              color: 'Default',
              title: 'SigEp Bookstore',
              amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
              amazon_secret_key: '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',
              amazon_associate_tag: 'sigep-grmbkstr-20',
              bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
              bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
              bookbyte_publisher_id: 'K620292',
              cj_website_id: '7208987',
              cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
              cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
              bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
              bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
              chegg_base_url: 'http://api.chegg.com/rent.svc',
              chegg_password: '4190344',
              chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
              chegg_aid: '10692263',
              chegg_pid: '7208987',
              chegg_sid: '',
              url: 'http://sigep.grmbkstr.com'
)

#pikapp
Tenant.create(sub_domain: 'pikapp',
              logo: 'pikappa_small.png',
              color: 'Default',
              title: 'Pi Kappa Phi Bookstore',
              amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
              amazon_secret_key: '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',
              amazon_associate_tag: 'pikapp-grmbkstr-20',
              bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
              bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
              bookbyte_publisher_id: 'K620292',
              cj_website_id: '7225069',
              cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
              cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
              bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
              bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
              chegg_base_url: 'http://api.chegg.com/rent.svc',
              chegg_password: '4190344',
              chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
              chegg_aid: '10692263',
              chegg_pid: '7225069',
              chegg_sid: '',
              url: 'http://pikapp.grmbkstr.com'
)

#pike
Tenant.create(sub_domain: 'pike',
              logo: 'PIKE_small.jpg',
              color: 'Default',
              title: 'Pi Kappa Alpha Bookstore',
              amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
              amazon_secret_key: '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',
              amazon_associate_tag: 'pike-grmbkstr-20',
              bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
              bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
              bookbyte_publisher_id: 'K620292',
              cj_website_id: '7225058',
              cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
              cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
              bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
              bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
              chegg_base_url: 'http://api.chegg.com/rent.svc',
              chegg_password: '4190344',
              chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
              chegg_aid: '10692263',
              chegg_pid: '7225058',
              chegg_sid: '',
              url: 'http://pike.grmbkstr.com'
)