module App
  module Statistics
    class LinksController < BaseController

      def index
        @links = @account.links
      end

      def show
        @link = @account.links.find params[:id]
        @link = @link.refresh_statistics!
      end

    end
  end
end
