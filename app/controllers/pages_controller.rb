class PagesController < ApplicationController
  def home
    @slots = Scheduler.new.call
  end
end
