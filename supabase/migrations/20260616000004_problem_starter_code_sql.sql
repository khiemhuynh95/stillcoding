-- StillCoding — per-problem starter code (SQL / database problems)
--
-- Database problems are solved in SQL, so their starter goes under the
-- `sql` language key (the editor shows it when SQL is selected). These are
-- schema-aware stubs; a reference query was verified against sample data
-- with sqlite3 at generation time. Keyed by title_slug; a slug not in the
-- catalog is a no-op. Column created by the earlier migration.

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Person(personId, firstName, lastName)
-- Address(addressId, personId, city, state)
-- Report firstName, lastName, city, state for every person; city and state are
-- NULL when the person has no address. Any row order is accepted.
--
-- Write your query below.
$sc$)
where title_slug = 'combine-two-tables';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Customers(id, name); Orders(id, customerId)
-- Report the names (as column "Customers") of customers who never ordered.
--
-- Write your query below.
$sc$)
where title_slug = 'customers-who-never-order';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Person(id, email)
-- Report each email (column "Email") that appears more than once.
--
-- Write your query below.
$sc$)
where title_slug = 'duplicate-emails';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Employee(id, name, salary, managerId)
-- Report the names (column "Employee") of employees earning more than their
-- manager.
--
-- Write your query below.
$sc$)
where title_slug = 'employees-earning-more-than-their-managers';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- World(name, continent, area, population, gdp)
-- A country is big if area >= 3000000 or population >= 25000000.
-- Report name, population, area of the big countries.
--
-- Write your query below.
$sc$)
where title_slug = 'big-countries';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Courses(student, class)
-- Report each class that has at least 5 students.
--
-- Write your query below.
$sc$)
where title_slug = 'classes-more-than-5-students';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Weather(id, recordDate, temperature)
-- Report the id of all dates whose temperature is higher than the previous
-- (the day before).
--
-- Write your query below.
$sc$)
where title_slug = 'rising-temperature';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Employee(id, salary)
-- Report the second highest distinct salary (column "SecondHighestSalary"),
-- or NULL if it does not exist.
--
-- Write your query below.
$sc$)
where title_slug = 'second-highest-salary';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Scores(id, score)
-- Report each score with its rank (column "rank"): highest score is rank 1, and
-- ties share a rank with no gaps. Order by score descending.
--
-- Write your query below.
$sc$)
where title_slug = 'rank-scores';

update public.problems
set starter_code = jsonb_build_object('sql', $sc$-- Logs(id, num)
-- Report all numbers (column "ConsecutiveNums") that appear at least three
-- times consecutively (by increasing id).
--
-- Write your query below.
$sc$)
where title_slug = 'consecutive-numbers';
