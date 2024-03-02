"""
Prog 2
W01
P01 2.1 Classroom objects

Authors:
Gwendoline Vocat (Vocatgwe), Gian Gamper (Gampegia), Jonas Bratschi (Bratsjon)

Date: 02.03.2024
"""

class Classroom:
    def __init__(self, tables=None, blackboard=None, teacher=None, documents=None, students=None):
        """Class to represent a classroom."""
        self.tables = tables if tables is not None else []
        self.blackboard = blackboard
        self.teacher = teacher
        self.documents = documents if documents is not None else []
        self.students = students if students is not None else []


class Document:
    def __init__(self, name):
        """Class to represent a document."""
        self.name = name


class Copies:
    def __init__(self, document, number_of_copies):
        """Class to represent copies of a document."""
        self.document = document
        self.number_of_copies = number_of_copies
        self.copies = []

    def copy_document(self):
        """Copy the document a specified number of times."""
        for index in range(self.number_of_copies):
            copy_name = f"{self.document.name}_{index + 1}"
            copy = Document(copy_name)
            self.copies.append(copy)
        return self.copies


class Table:
    def __init__(self, students_per_table, students, document):
        """Class to represent a table in the classroom."""
        self.students_per_table = students_per_table
        self.students = students
        self.document = document


class Human:
    def __init__(self, role, name, owns=None):
        """Class to represent a human in the classroom."""
        self.role = role
        self.name = name
        self.owns = owns if owns is not None else []

    def write_your_name(self):
        """Return the name of the human."""
        return self.name


class Blackboard:
    def __init__(self, name, text):
        """Class to represent a blackboard in the classroom."""
        self.name = name
        self.text = text


# Constants
nr_copies = 20
nr_students = 20
students_per_table = 2
copies_per_student = 1
nr_teachers = 1
nr_tables = 10

# Create document and copies
document_1 = Document("The basics of witchcraft")
copies_1 = Copies(document_1, nr_copies)
copied_documents = copies_1.copy_document()

# Create students and distribute copies
students = [Human("student", f"student_{index + 1}", [copied_documents[index]]) for index in range(nr_students)]

# Create tables and distribute students to tables
tables = []
for index in range(nr_tables):
    table_students = students[index * students_per_table: (index + 1) * students_per_table]
    table_document = copied_documents[index % nr_copies]  # Assign a document to each table
    table = Table(students_per_table, table_students, table_document)
    tables.append(table)

# Create teacher and write name to blackboard
teacher_1 = Human("teacher", "Dumbledore")
blackboard_1 = Blackboard("Front Blackboard", teacher_1.write_your_name())

# Instantiate the Classroom
classroom = Classroom(tables, blackboard_1, teacher_1, copied_documents, students)

# Print every attribute of the first object for each class
print("First Classroom:")
print("  Teacher Name:", classroom.teacher.name)
print("  Blackboard Text:", classroom.blackboard.text)
print("  Number of Tables:", len(classroom.tables))
print("  Number of Students:", len(classroom.students))
print("  Number of Documents:", len(classroom.documents))

print("\nFirst Table:")
print("  Students per Table:", tables[0].students_per_table)
print("  Students:")
for student in tables[0].students:
    print(f"    Student Name: {student.name}, Document Name: {student.owns[0].name}")
print("  Document Name:", tables[0].document.name)

print("\nFirst Document:")
print("  Document Name:", copied_documents[0].name)

print("\nFirst Student:")
print("  Role:", students[0].role)
print("  Name:", students[0].name)
print("  Document Name:", students[0].owns[0].name)

print("\nFirst Teacher:")
print("  Role:", teacher_1.role)
print("  Name:", teacher_1.name)

print("\nFirst Blackboard:")
print("  Name:", blackboard_1.name)
print("  Text:", blackboard_1.text)
