
class WorkingHoursController < ApplicationController
    before_action :set_working_hours, only: %i[show edit update destroy]
  
    def index
      @working_hours = WorkingHour.all
    end
  
    def show
    end
  
    def new
      @working_hours = WorkingHour.new
    end
  
    def edit
    end
  
    def update
      if @working_hours.update(working_hours_params)
        redirect_to @working_hours, notice: 'Working hours updated successfully.'
      else
        render :edit
      end
    end
  
    def destroy
      @working_hours.destroy
      redirect_to working_hours_path, notice: 'Working hours deleted successfully.'
    end
  
    private
  
    def set_working_hours
      @working_hours = WorkingHour.find(params[:id])
    end
  
    def working_hours_params
      params.require(:working_hours).permit(:day, :start_time, :end_time)
    end
  end
  
  # app/models/working_hour.rb
  class WorkingHour < ApplicationRecord
    validates :day, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
  end
  
  # app/views/working_hours/index.html.erb
  <h1>Working Hours</h1>
  
  <table>
    <thead>
      <tr>
        <th>Day</th>
        <th>Start Time</th>
        <th>End Time</th>
      </tr>
    </thead>
  
    <tbody>
      <% @working_hours.each do |working_hour| %>
        <tr>
          <td><%= working_hour.day %></td>
          <td><%= working_hour.start_time %></td>
          <td><%= working_hour.end_time %></td>
        </tr>
      <% end %>
    </tbody>
  </table>
  
  <%= link_to 'New Working Hour', new_working_hour_path %>
  
  # app/views/working_hours/show.html.erb
  <h1>Working Hours</h1>
  
  <p>
    Day: <%= @working_hours.day %>
  </p>
  
  <p>
    Start Time: <%= @working_hours.start_time %>
  </p>
  
  <p>
    End Time: <%= @working_hours.end_time %>
  </p>
  
  <%= link_to 'Edit', edit_working_hour_path(@working_hours) %>
  <%= link_to 'Destroy', @working_hours, method: :delete, data: { confirm: 'Are you sure?' } %>
  
  # app/views/working_hours/new.html.erb
  <h1>New Working Hour</h1>
  
  <%= form_for(@working_hours) do |f| %>
    <div class="field">
      <%= f.label :day %>
      <%= f.text_field :day %>
    </div>
  
    <div class="field">
      <%= f.label :start_time %>
      <%= f.time_field :start_time %>
    </div>
  
    <div class="field">
      <%= f.label :end_time %>
      <%= f.time_field :end_time %>
    </div>
  
    <div class="actions">
      <%= f.submit %>
    </div>
  <% end %>
  
  # app/views/working_hours/edit.html.erb
  <h1>Edit Working Hour</h1>
  
  <%= form_for(@working_hours) do |f| %>
    <div class="field">
      <%= f.label :day %>
      <%= f.text_field :day %>
    </
  