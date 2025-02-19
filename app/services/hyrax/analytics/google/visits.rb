# frozen_string_literal: true
module Hyrax
  module Analytics
    module Google
      module Visits
        extend Legato::Model

        dimensions :user_type
        metrics :sessions

        def self.results_array(response)
          results = []
          response.to_a.each do |result|
            results.push([result.date.to_date, result.result.sessions.to_i])
          end
          Hyrax::Analytics::Results.new(results)
        end

        def self.new_visits(profile, start_date, end_date)
          x = Visits.results(profile,
            start_date: start_date,
            end_date: end_date).to_a
          x.first.sessions.to_i
        end

        def self.return_visits(profile, start_date, end_date)
          x = Visits.results(profile,
            start_date: start_date,
            end_date: end_date).to_a
          x.last.sessions.to_i
        end

        def self.total_visits(profile, start_date, end_date)
          x = Visits.results(profile,
            start_date: start_date,
            end_date: end_date).to_a
          new_visits = x.first.sessions.to_i
          returning_visits = x.last.sessions.to_i
          new_visits + returning_visits
        end
      end
    end
  end
end
