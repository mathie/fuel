# UK Fuel Prices

## Data Source

I got the data from here:

* The CSV file here: <https://www.gov.uk/government/statistical-data-sets/oil-and-petroleum-products-weekly-statistics>

I took the CSV file, then dumped it in the `db` folder for import. So far I've
skipped the fuel duty and VAT rate, but I wonder if "normalising" the data by
removing them might be interesting.

## Random TODO list

* Graph the cost of a barrel of oil for the same time periods on the fuel
  prices graph.

* Have a check box that allows folks to discount fuel duty and/or VAT, to see
  the effect that tax has on the cost of fuel.

* Let folks record fuel usage. I'm looking to record: usage period (start ->
  end date), number of miles, fuel type and the average MPG reported by the
  car. Given this, we should be able to start plotting the cost of the fuel
  (using the averages we have stored) over time.

* Graph fuel usage over time, in terms of cost.

* Compare different fuel usage scenarios. This is what I really wanted to do
  in the first place. Given a number of miles over a period of time and an
  estimated MPG, display the cost of petrol vs. diesel. As a practical
  example, having done 4,000 miles in the new C4 diesel over the past 4
  months, averaging, according to the computer in there, 43mpg, how does that
  compare to the 29.8mpg we were getting in the Volvo?

## Getting started

To run the app locally, make sure you've got Ruby 1.9.x installed (I'm using
1.9.3, installed through rbenv) and PostgreSQL running. Install the gem
dependencies with:

    bundle install

then create the database and insert the fuel price data:

    createuser -s fuel
    rake db:create:all
    rake db:reset

Now you can run the app server with:

    foreman start

and visit <http://localhost:5000/fuel_prices> to check out the fuel price data.