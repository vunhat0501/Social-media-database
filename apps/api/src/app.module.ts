import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { DatabaseModule } from './database/database.module';
import { APP_FILTER, APP_INTERCEPTOR } from '@nestjs/core';
import { AllExceptionFilter } from '@/common/filter/all-exception/all-exception.filter';
import { LoggerMiddleware } from '@/common/middleware/logger/logger.middleware';
import { UserModule } from './user/user.module';
import { TransformInterceptor } from '@/common/interceptor/transform/transform.interceptor';
import { TimeoutInterceptor } from '@/common/interceptor/timeout/timeout.interceptor';
import { PostsModule } from './posts/posts.module';
import { StoriesModule } from './stories/stories.module';
import { BookmarksModule } from './bookmarks/bookmarks.module';
import { SocialModule } from './social/social.module';

@Module({
  imports: [
    AuthModule,
    DatabaseModule,
    UserModule,
    PostsModule,
    StoriesModule,
    BookmarksModule,
    SocialModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_FILTER,
      useClass: AllExceptionFilter,
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: TransformInterceptor,
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: TimeoutInterceptor,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(LoggerMiddleware).forRoutes('*');
  }
}
