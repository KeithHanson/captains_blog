class CaptainsBlog::BlogAdmin::Categories
  
  attr_accessor :request, :response, :logger

  def index
    response.render "blog_admin/categories/index", :layout => "layouts/blog_admin", :categories => Category.roots
  end

  def show(category_id)
    response.render "blog_admin/categories/show", :layout => "layouts/blog_admin", :category => Category.get(category_id)
  end

  def new
    response.render "blog_admin/categories/new", :layout => "layouts/blog_admin", :category => Category.new
  end

  def edit(category_id)
    response.render "blog_admin/categories/edit", :layout => "layouts/blog_admin", :category => Category.get(category_id)
  end

  def create(category_params)
    category = Category.new
    category.attributes = category_params

    if category.save
      response.redirect "/blog-admin/categories/#{category.id}", :layout => "layouts/blog_admin", :message => "Saved Category #{category.to_s}"
    else
      response.render "blog_admin/categories/new", :layout => "layouts/blog_admin", :category => category
    end
  end

  def update(category_id, category_params)
    category = Category.get(category_id)
    category.attributes = category_params

    if category.save
      response.redirect "/blog-admin/categories/#{category.id}", :layout => "layouts/blog_admin", :message => "Saved Category #{category.to_s}"
    else
      response.render "blog_admin/categories/show", :layout => "layouts/blog_admin", :category => category
    end
  end

  def delete(category_id)
    category = Category.get(category_id)

    if request.xhr?
      return response.puts(category.destroy)
    else
      if category.destroy
        response.redirect "/blog-admin/categories", :layout => "layouts/blog_admin", :message => "Deleted Category #{category.to_s}"
      else
        response.render "blog_admin/categories/show", :layout => "layouts/blog_admin", :category => category
      end
    end
  end

end