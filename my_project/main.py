import psycopg2
def function():

    DB_NAME = "postgres"
    DB_USER = "postgres"
    DB_PASS = "password"
    DB_HOST = "127.0.0.1"
    DB_PORT = "5432"


    conn = psycopg2.connect(database=DB_NAME,
                                user=DB_USER,
                                password=DB_PASS,
                                host=DB_HOST,
                                port=DB_PORT)
    print("Database connected successfully")

    cur = conn.cursor()
    cur.execute("select * from category")
    rows = cur.fetchall()
    inp=30
    list=[]
    while inp!=77777:
        for data in rows:
            if data[0]==inp:
                list.append(data[1])
                inp=data[2]
    for l in list:
        print(l)
   
    return list


def getHtml(list) :
    html_content = f"""
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <h1>Product categories</h1>
       <select name="category" id="category">
 """
    
    for l in list :
            html_content+= f"""
               <option value="{l}">{l}</option>
            """
    html_content+="""
       </select>
    </body>
    </html>
    """
 
    with open('output.html','w') as file :
         file.write(html_content)
 
data = function()
getHtml(data)




 



 

 