# app/models/working_hours.rb
class WorkingHours < ApplicationRecord
    has_many :slots
  
    validates :day, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
  
    def self.available_hours(day)
      slots = Slot.where(day: day)
      slots.map do |slot|
        {
          start_time: slot.start_time,
          end_time: slot.end_time
        }
      end
    end
  end
  
  # app/models/slot.rb
  class Slot < ApplicationRecord
    belongs_to :working_hours
  
    validates :start_time, presence: true
    validates :end_time, presence: true
  
    def self.available_slots(day)
      WorkingHours.available_hours(day).map do |working_hours|
        slots = Slot.where(day: day, working_hours_id: working_hours[:id])
        slots.map do |slot|
          {
            start_time: slot.start_time,
            end_time: slot.end_time
          }
        end
      end
    end
  end
  
  # app/views/working_hours/index.html.erb
  <h1>Working Hours</h1>
  
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
  
  <h2>Available Hours</h2>
  
  <%= render partial: "slots", locals: { slots: WorkingHours.available_hours(@working_hours.day) } %>
  