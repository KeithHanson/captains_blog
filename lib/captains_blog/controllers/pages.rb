class CaptainsBlog::Pages
  
  attr_accessor :request, :response, :logger, :blog

  def index
    response.render blog.page("pages/index"), :layout => blog.page("layouts/blog"), :blog => blog, :posts => blog.articles
  end

  # def handle_page_request(path)
  #   article = Article.first(:url => path)
  # 
  #   response.render blog.page('pages/show_post'), :layout => blog.page('layouts/blog'), :blog => blog, :post => article
  # end

  def show_post(slug)
    post = blog.posts.first(:slug => slug)

    response.render blog.page('pages/show_post'), :layout => blog.page('layouts/blog'), :blog => blog, :post => post
  end

  def leave_comment(post_slug, comment_params)
    post = blog.posts.first(:slug => post_slug)
    comment = Comment.new(comment_params.update(:post => post))
    if comment.save
      response.redirect request.referrer, :message => "Thanks, you're comment will appear shortly"
    else
      raise "no"
    end

  end

end