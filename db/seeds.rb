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
    chegg_sid: 'aoii',
    url: 'http://aoii.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=aoii'
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
    chegg_sid: 'gremlin',
    url: 'http://www.gremlinbooks.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=Gremlin'
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
    chegg_sid: 'chipsi',
    url: 'http://chipsi.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=chipsi'
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
    chegg_sid: 'alphasig',
    url: 'http://alphasig.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=alphasig'
)

#Sig Ep
Tenant.create(sub_domain: 'sigep',
    logo: 'Gb with Sigep.png',
    color: 'Default',
    title: 'Gremlin Books',
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
    chegg_sid: 'sigep',
    url: 'http://sigep.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=sigep'
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
    chegg_sid: 'pikapp',
    url: 'http://pikapp.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=pikappa'
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
    chegg_sid: 'pike',
    url: 'http://pike.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=pike'
)

#kappa kappa gamma
Tenant.create(sub_domain: 'kkg',
    logo: 'kkglogo_RIFV2.png',
    color: 'Default',
    title: 'Gremlin Books | Kappa Kappa Gamma',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'kkg-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7225064',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7225064',
    chegg_sid: 'kkg',
    url: 'http://kkg.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=kkg'
)

#UIU Link
Tenant.create(sub_domain: 'uiulink',
    logo: 'uiu_logo.png',
    color: 'Default',
    title: 'UIU Link Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'uiulink-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7279899',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7279899',
    chegg_sid: 'uiulink',
    url: 'http://uiulink.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=uiulink'
)

#pi_beta_phi
Tenant.create(sub_domain: 'piphi',
    logo: 'pi_beta_phi.jpg',
    color: 'Default',
    title: 'Pi Beta Phi Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'piphi-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7355825',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7355825',
    chegg_sid: 'piphi',
    url: 'http://piphi.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=piphi'
)

#sigma nu
Tenant.create(sub_domain: 'sigmanu',
    logo: 'sigmanu.png',
    color: 'Default',
    title: 'Sigma Nu Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'sigmanu-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7493665',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7493665',
    chegg_sid: 'sigmanu',
    url: 'http://sigmanu.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=sigmanu'
)

#chi omega
Tenant.create(sub_domain: 'chiomega',
    logo: 'chiomega.png',
    color: 'Default',
    title: 'Chi Omega Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'chiomega-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7499187',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7499187',
    chegg_sid: 'chiomega',
    url: 'http://chiomega.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=chiomega'
)

#Kappa Alpha Theta
Tenant.create(sub_domain: 'kat',
    logo: 'kat.png',
    color: 'Default',
    title: 'Kappa Alpha Theta Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'kat-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7499189',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7499189',
    chegg_sid: 'kat',
    url: 'http://kat.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=kat'
)

#kappa delta
Tenant.create(sub_domain: 'kappa delta',
    logo: 'kappadelta.png',
    color: 'Default',
    title: 'Kappa Delta Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'kappadelta-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7499190',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7499190',
    chegg_sid: 'kappadelta',
    url: 'http://kappadelta.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=kappadelta'
)

#Tau Kappa Epsilon
Tenant.create(sub_domain: 'Tau Kappa Epsilon',
    logo: 'tke.png',
    color: 'Default',
    title: 'Tau Kappa Epsilon Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'tke-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7499191',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7499191',
    chegg_sid: 'tke',
    url: 'http://tke.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=tke'
)

#sigma kappa
Tenant.create(sub_domain: 'sigmakappa',
    logo: 'sigmakappa.png',
    color: 'Default',
    title: 'Sigma Kappa Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'sigmakappa-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7499192',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7499192',
    chegg_sid: 'sigmakappa',
    url: 'http://sigmakappa.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=sigmakappa'
)

#delta gamma
Tenant.create(sub_domain: 'deltagamma',
    logo: 'deltagamma.png',
    color: 'Default',
    title: 'Delta Gamma Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'deltagamma-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '7499194',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '7499194',
    chegg_sid: 'deltagamma',
    url: 'http://deltagamma.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=deltagamma'
)
#HerCampus
Tenant.create(sub_domain: 'hercampus',
    logo: 'hercampus.png',
    color: 'Default',
    title: 'hercampus Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'hercampus-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '8223325',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '8223325',
    chegg_sid: 'hercampus',
    url: 'http://hercampus.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=hercampus'
)
#College Summit
Tenant.create(sub_domain: 'collegesummit',
    logo: 'collegesummit.png',
    color: 'Default',
    title: 'College Summit Bookstore',
    amazon_access_key: 'AKIAJGEEG4RCTCF2DCHQ',
    amazon_secret_key: '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',
    amazon_associate_tag: 'collegesummit-grmbkstr-20',
    bookbyte_base_url: 'http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx',
    bookbyte_auth_token: 'Lk1YwBqGUVIa4QOOcNT6oA==',
    bookbyte_publisher_id: 'K620292',
    cj_website_id: '8223330',
    cj_auth_key: '00b18d488889010d9f0176f59a2777cc296a56f575ed4c60009640d9af3f2ed449a0d21b3e679c8a91f86feb0936ba39518552541da59ba373f8b573b7b76d3539/1ac9d647c364054a184e7a7fe7b48b7934322a96c056e5a5310657d1b916b7b0a3abd613937ca76f2ae0d542988eea0fcbd03a15475deebc6a85a305e5c59a01',
    cj_base_url: 'https://product-search.api.cj.com/v2/product-search',
    bookrenter_base_url: 'http://www.bookrenter.com/api/fetch_book_info',
    bookrenter_developer_key: 'FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf',
    chegg_base_url: 'http://api.chegg.com/rent.svc',
    chegg_password: '4190344',
    chegg_key: '1522fa5538fd041d8855c507ac1bf6a5',
    chegg_aid: '10692263',
    chegg_pid: '8223330',
    chegg_sid: 'collegesummit',
    url: 'http://collegesummit.grmbkstr.com',
    sell_books_url: 'http://www.valorebooks.com/sell-textbooks?IsIFrame=1&w=640&site_id=sAx095&t_id=collegesummit'
)