test_that('P1 looks good',{
  P1 = c(60) %>% mami.codi()
  expect_true(P1$consonance_dissonance > 0)
})
test_that('P1 pure tone looks good',{
  P1 = c(60) %>% mami.codi(num_harmonics=1)
  expect_true(P1$consonance_dissonance > 0)
})
