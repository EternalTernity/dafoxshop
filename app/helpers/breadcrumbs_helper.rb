# app/helpers/breadcrumb_helper.rb
module BreadcrumbsHelper
  def breadcrumb(product)
    crumbs = []
    category = product.category

    # Build breadcrumb from category to root
    while category
      crumbs << link_to(category.name, root_path)
      category = category.parent_category # If you have a nested category setup
    end

    crumbs.reverse!
    crumbs << product.name # Add the product at the end of the breadcrumb
    crumbs.join(" > ").html_safe
  end
end
