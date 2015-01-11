def var="hello "+

        "world"+

        ",groovy!"

def repeatx(val,repeat=3){

    for(i in 0..<repeat){

        println "This is ${i}:${val}"

    }

}

repeatx(var);