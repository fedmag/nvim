async function seedEuProducts(
  payload: BasePayload,
  dbData: ImportProduct[],
  logoMap: Map<string, number | undefined>,
  categoryMap: Map<string, number>,
  subcategoryMap: Map<string, number>,
  countryMap: Map<string, number>,
  replacedProdMap: Map<string, number>,
) {
  console.log('...creating eu-products...')
  const prodPromises = dbData.map((product: ImportProduct) => {
    //logo
    const logoIndex: number | undefined = logoMap.get(product.logo)

    // category
    const categoryIndex: number | undefined = categoryMap.get(product.categories)
    const categoryIds = categoryIndex !== undefined ? [categoryIndex] : null

    // subcategory
    const subcategoryIndex: number | undefined = subcategoryMap.get(product.subcategory)
    const subcategoryIds = subcategoryIndex !== undefined ? [subcategoryIndex] : null

    // produced in
    const producedIn: number[] = []
    if (product.producedIn?.includes(',')) {
      product.producedIn
        .split(',')
        .filter((c: string) => c.trim() !== '')
        .forEach((s: string) => producedIn.push(countryMap.get(s)!))
    } else {
      if (product.producedIn.trim() === '') {
        console.log(`product ${product.name} has an empty producedIn field`)
      } else {
        producedIn.push(countryMap.get(product.producedIn)!)
      }
    }

    // produced in
    const companyRegistrationCountries: number[] = []
    if (product.companyRegistrationCountry?.includes(',')) {
      product.companyRegistrationCountry
        .split(',')
        .filter((c: string) => c.trim() !== '')
        .forEach((s: string) => companyRegistrationCountries.push(countryMap.get(s)!))
    } else {
      if (product.companyRegistrationCountry.trim() === '') {
        console.log(`product ${product.name} has an empty companyRegistrationCountry`)
      } else {
        companyRegistrationCountries.push(countryMap.get(product.companyRegistrationCountry)!)
      }
    }

    // replaced product
    const replacedProds: number[] = []
    if (product.replaces?.includes(',')) {
      product.replaces.split(',').forEach((s: string) => {
        const foundElement = replacedProdMap.get(s)
        if (foundElement) {
          replacedProds.push(foundElement)
        }
      })
    } else {
      const foundElement = replacedProdMap.get(product.replaces)
      if (foundElement) replacedProds.push(foundElement)
    }

    return payload.create({
      collection: 'eu-products',
      data: {
        name: String(product.name),
        categories: categoryIds,
        subcategories: subcategoryIds,
        producedIn: producedIn,
        companyRegistrationCountry: companyRegistrationCountries,
        availableIn: null, // this is just for testing, this value is not present in the current db
        description: product.description,
        replaces: replacedProds,
        logo: logoIndex,
        link: product.link,
        seoSlug: String(product.name),
        seoDescription: product.description,
        seoTitle: String(product.name),
        _status: 'published',
      },
    })
  })
  await Promise.all(prodPromises)
}

