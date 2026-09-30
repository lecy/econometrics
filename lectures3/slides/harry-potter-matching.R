library( dplyr )

dat <- read.table( "clipboard", header=T, sep="\t", stringsAsFactors=F )

> names( dat )
[1] "Have.you.read.some.or.all.of.the.books.from.the.Harry.Potter.series."
[2] "Have.you.seen.any.of.the.Harry.Potter.movies."                       
[3] "Do.you.read.fiction.often.for.fun."                                  
[4] "Do.enjoy.science.fiction.or.fantasy.genres."                         
[5] "Do.you.have.children.over.eight.years.in.age."                       
[6] "What.is.your.sex."                                                   
[7] "What.is.your.age."                                                   
[8] "What.is.your.race."

questions <- names( dat )

names( dat ) <- c("books","movies","fiction","scifi",
                  "children","male","age","race")


dat$books     <- ( dat$books == "Yes" )    %>% as.numeric()
dat$movies    <- ( dat$movies == "Yes" )   %>% as.numeric()
dat$fiction   <- ( dat$fiction == "Yes" )  %>% as.numeric()
dat$scifi     <- ( dat$scifi == "Yes" )    %>% as.numeric()
dat$children  <- ( dat$children == "Yes" ) %>% as.numeric()
dat$male      <- ( dat$male == "Male" ) %>% as.numeric()
dat$race      <- tolower( dat$race )


dat <- 
structure(list(books = c(1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 
0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0), movies = c(1, 
1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 
1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 
0, 1, 1, 0, 0, 1, 1, 1), fiction = c(0, 0, 0, 1, 0, 0, 1, 1, 
0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 
1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 
1), scifi = c(1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 
0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 
0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0), children = c(0, 0, 
0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0), male = c(1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 
0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 
0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0), 
    age = c(37L, 34L, 33L, 35L, 26L, 31L, 34L, 25L, 29L, 25L, 
    37L, 42L, 31L, 34L, 58L, 28L, 35L, 36L, 28L, 37L, 37L, 25L, 
    25L, 25L, 27L, 25L, 23L, 36L, 24L, 28L, 23L, 26L, 26L, 32L, 
    66L, 43L, 25L, 61L, 25L, 34L, 24L, 22L, 24L, 24L, 25L, 28L, 
    28L, 28L, 29L, 31L, 26L), race = c("white", "white", "white", 
    "white", "asian", "black", "white", "black", "asian", "white", 
    "black", "black", "black", "white", "black", "black", "white", 
    "black", "other", "white", "black", "black", "white", "white", 
    "asian", "white", "asian", "white", "white", "white", "white", 
    "white", "white", "white", "other", "black", "asian", "black", 
    "black", "white", "white", "white", "white", "black", "white", 
    "white", "white", "black", "black", "other", "black")), 
  row.names = c(NA, 
  -51L), class = "data.frame")



library( MatchIt )



table( dat$books )





m1 <- lm( books ~ movies + fiction + scifi + 
          children + male + age + factor(race), 
          data=dat )

summary( m1 )

dat$p.score <- m1$fitted.values %>% round(2)

dat <- arrange( dat, - p.score )

col.order <- c( "p.score", "books", "movies", "fiction", 
                   "scifi", "children", "male", "age", "race" )

dat <- dat[ col.order ]



## DESCRIBE DATA

dat %>% 
  group_by( books ) %>% 
  summarize( mean.age = mean(age),
             prop.male = mean(male),
             prop.children = mean(children),
             prop.white = mean( race == "white" ),
             prop.black = mean( race == "black" ), 
             prop.asian = mean( race == "asian" ) )
    


### MODEL THE DATA

m1 <- lm( books ~ movies + fiction + scifi + 
          children + male + age + factor(race), 
          data=dat )

summary( m1 )

dat$p.score <- m1$fitted.values %>% round(2)

dat <- arrange( dat, - p.score )
dat$id <- 1:nrow(dat)

col.order <- c( "id", "p.score", "books", "movies", "fiction", 
                   "scifi", "children", "male", "age", "race" )

dat <- dat[ col.order ]

dat$white <- as.numeric( dat$race == "white" )
dat$black <- as.numeric( dat$race == "black" )
dat$asian <- as.numeric( dat$race == "asian" )





m.out <- matchit( treat ~ x1 + x2, data = mydata )


m.out <- matchit( books ~ movies + fiction + scifi + children + 
                  male + age + white + black + asian, data=dat )

summary( m.out )

install.packages( "rgenoud" )

m.out <- matchit( books ~ movies + fiction + scifi + children + 
                  male + age + white + black + asian, data=dat,
                   method="genetic" )

m.out 

summary( m.out )




m.out <- matchit( books ~ movies + fiction + scifi + children + 
                  male + age + white + black + asian, data=dat,
                  method="nearest", discard="both" )

m.out 

summary( m.out )

match.data( m.out )






names( dat ) %>% dput()


keep <- c("id","books", "movies", "fiction", "scifi", "children", 
"male", "age", "race", "white", "black", "asian")
d2 <- dat[ keep ]
write.csv( d2, "harry-potter.csv", row.names=F )



