class SearchController < ApplicationController
  def search
    @events = Event.where("name LIKE ? or description LIKE ?",
                          "%#{Event.sanitize_sql_like(params[:q])}%",
                          "%#{Event.sanitize_sql_like(params[:q])}%")

    logger.debug(render_to_string layout: "search")
    render layout: "search"
  end
end
