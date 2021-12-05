# this tutorial is based on the series of videos on python OOP by corey schafer
# https://www.youtube.com/playlist?list=PL-osiE80TeTsqhIuOqKhwlXsIBIdSeYtc
# this page is useful as well
# https://realpython.com/instance-class-and-static-methods-demystified/

# let's use OOP to provide a way of constructing a database containing employee data for a company
# each instance of the class should then refer to a given employee
# one way of doing that is using solely an instance method, like so:
class Employee:
    def __init__(self, first_name, last_name, wage):
        self.first_name = first_name
        self.last_name = last_name
        self.wage = wage


employee1 = Employee("Bruce", "Wayne", 10000)
print(employee1)
# the __dict__ attribute is useful
print(employee1.__dict__)

print('-------------------------------------------------------')
print('class method')
print('-------------------------------------------------------')

# another way of doing it would be to use a class method as an alternative constructor
# say we had employee data as strings, such as "Bruce-Wayne-10000"
# we can pass the string as an argument to the class method
# the class method returns objects which are then used to initialize an instance


class Employee:
    def __init__(self, first_name, last_name, wage):
        self.first_name = first_name
        self.last_name = last_name
        self.wage = wage

    @classmethod
    def from_string(cls, employee_str):
        first_name, last_name, wage = employee_str.split('-')
        return cls(first_name, last_name, wage)


employee1 = Employee.from_string("Bruce-Wayne-10000")
# the class method instantiates the class, but we get
# the same result as above, this is the concept of using a
# class method as an alternative constructor
print(employee1)
print(employee1.__dict__)
# note that the class method points to the class, using a cls argument,
# instead of pointing to the instance (which would use a self argument)

print('-------------------------------------------------------')

# class methods can change class attributes, which are shared across instances
# let's say we need a method to raise wages of an employee. The default
# raise we want to aply is 1000, but we may want to aply it more times for
# some employees compared to others. this is how we do it


class Employee:
    raise_wage = 1000

    def __init__(self, first_name, last_name, wage):
        self.first_name = first_name
        self.last_name = last_name
        self.wage = wage

    def raise_amount(self):
        # calling this method will raise the wage of an employee
        self.wage += self.raise_wage

    # @classmethod
    # def set_raise_wage(cls, raise_wage):
    #     cls.raise_wage += raise_wage


employee1 = Employee("Bruce", "Wayne", 10000)
print(employee1.wage)
employee1.raise_amount()
employee1.raise_amount()
employee1.raise_amount()
print(employee1.wage)

employee2 = Employee("Clark", "Kent", 5000)
print(employee2.wage)
employee2.raise_amount()
print(employee2.wage)

print('-------------------------------------------------------')

# if we use a class method, it will aply the wage for all employees


class Employee:
    raise_wage = 0

    def __init__(self, first_name, last_name, wage):
        self.first_name = first_name
        self.last_name = last_name
        self.wage = wage

    def raise_amount(self):
        # calling this method will raise the wage of an employee
        self.wage += self.raise_wage

    @classmethod
    def set_raise_wage(cls, raise_wage):
        cls.raise_wage += raise_wage


employee1 = Employee("Bruce", "Wayne", 10000)
Employee.set_raise_wage(2000)
print(employee1.wage)
employee1.raise_amount()
print(employee1.wage)

employee2 = Employee("Clark", "Kent", 5000)
print(employee2.wage)
employee2.raise_amount()
print(employee2.wage)
# the same raise was applied to both instances. if we want to apply different
# raises to the instances, we can then change the attribute of an instance instead
# of the class

employee1.raise_wage = 5000
print(employee1.wage)
employee1.raise_amount()
print(employee1.wage)

print('-------------------------------------------------------')
print('static methods')
print('-------------------------------------------------------')


# static methods do not change either object or class state, as they do not have
# access to classes or instances


class Employee:
    def __init__(self, first_name, last_name, wage):
        self.first_name = first_name
        self.last_name = last_name
        self.wage = wage

    @staticmethod
    def is_workday(day):
        if day.weekday() == 5 or day.weekday() == 6:
            return False
        return True


# the staticmethod above uses functionality from the datetime module to
# return whether a given date is a workday or not
import datetime
given_date = datetime.date(2020, 1, 12)
print(Employee.is_workday(given_date))

# static methods are useful for doing code maintenance, and one of the reasons
# for that is that one does not have to set up a class instance in order to
# test a static method in a unit test

print('-------------------------------------------------------')
print('inheritance')
print('-------------------------------------------------------')

# check my repo of game theory using python for an example of a class
# that inherits methods

# let's create a class 'employee' and a subclass 'manager' which holds
# a list of employees that are under the supervision of a manager


class Employee:
    def __init__(self, first_name, last_name, wage):
        self.first_name = first_name
        self.last_name = last_name
        self.wage = wage

class Manager(Employee):

    def __init__(self, first_name, last_name, wage, employees=None):
        super().__init__(first_name, last_name, wage)
        self.employees_list = []
        if employees is not None:
            for i in employees:
                self.employees_list.append(
                    [i.first_name, i.last_name])


# the manager class has its own __init__ method, but it inherits the functionality
# of the method from the employee class
# if we run help(Manager) we can check its method resolution order
# help(Manager)
manager1 = Manager("Martian", "Manhunter", "10000",
                   employees=[employee1, employee2])
print(manager1.__dict__)
print(manager1.employees_list)

# manager1 is an instance of both the manager and employee classes:
print(isinstance(manager1, Manager), isinstance(manager1, Employee))
print(issubclass(Manager, Employee))

print('-------------------------------------------------------')
print('dunder/magic methods')
print('-------------------------------------------------------')

# methods surrounded by underscores are called dunder or magic
# they are often used to modify built-in behavior in python
# besides __init__, two dunder methods are common, repr and str
# both are used to display information about the class, but repr is supposed
# to be read by developers, while logging or debugging,
# and str is supposed to be more general, and read by end users

class Employee:

    def __init__(self, first_name, last_name, wage):
        self.first_name = first_name
        self.last_name = last_name
        self.wage = wage


# notice what happens if we print an instance of the employee class
emp1 = Employee("Diana", "Prince", 50000)
print(emp1)

# now let's alter the class using the repr and str methods
class Employee:

    def __init__(self, first_name, last_name, wage):
        self.first_name = first_name
        self.last_name = last_name
        self.wage = wage

    def __repr__(self):
        return f'Employee({self.first_name}, {self.last_name}, {self.wage})'

    def __str__(self):
        return f'The employee {self.first_name} {self.last_name} earns {self.wage}'


emp1 = Employee("Diana", "Prince", 50000)
print(repr(emp1))
# notice that a good rule-of-thumb for the repr method is to return an object
# that can be used to recreate the class instance if we simply copy and
# paste the output and run it in python
print(str(emp1))

print('-------------------------------------------------------')
print('property decorators')
print('-------------------------------------------------------')

# let's say we have the following class
class Employee:

    def __init__(self, first_name, last_name):
        self.first_name = first_name
        self.last_name = last_name
        self.email = f'{first_name}{last_name}@domain.com'


# and we create the following instance
emp1 = Employee('Shayera', 'Hol')
print(emp1.email)
# now we need to change the instance's first and last name attributes
emp1.first_name = 'Shiera'
emp1.last_name = 'Hall'
print(emp1.first_name, emp1.last_name)
# this works, but it doesn't alter the email attribute
print(emp1.email)

# we could define an email method instead of setting the email as an attribute,
# but this is cumbersome and may break some codes
# a more efficient way to deal with this is using a property decorator
# a property decorator allows defining a method but accessing it as an attribute

class Employee:

    def __init__(self, first_name, last_name):
        self.first_name = first_name
        self.last_name = last_name

    @property
    def email(self):
        # self.email = first_name + last_name + '@domain.com'
        return f'{self.first_name}.{self.last_name}@domain.com'


print('\nusing property decorator>>>')
emp1 = Employee('Shayera', 'Hol')
print(emp1.email)
emp1.first_name = 'Shiera'
emp1.last_name = 'Hall'
print(emp1.first_name, emp1.last_name)
print(emp1.email)

# now let's say we want to change the email and also the first and last name
# objects. we can use a property decorator called setter for that

print('\nusing setter>>>')
class Employee:

    def __init__(self, first_name, last_name):
        self.first_name = first_name
        self.last_name = last_name

    @property
    def email(self):
        # self.email = first_name + last_name + '@domain.com'
        return f'{self.first_name}.{self.last_name}@domain.com'

    @email.setter
    def email(self, email):
        import re
        pattern = re.compile(r"@|\.")
        result = pattern.split(email)
        self.first_name = result[0]
        self.last_name = result[1]


emp1 = Employee('Shayera', 'Hol')
print(emp1.first_name, emp1.last_name)
print(emp1.email)
print('changing using setter')
emp1.email = 'Shiera.Hall@domain.com'
print(emp1.email)
print(emp1.first_name, emp1.last_name)
# if we want to delete an attribute, we can use a property called
# deleter instead of setter, and when we run, say, del emp1.email, it will
# run the method decorated by the deleter